from langchain.output_parsers import PydanticOutputParser
from src.models.question_schemas import MCQQuestion,FillBlankQuestion
from src.prompts.templates import mcq_prompt_template,fill_blank_prompt_template
from src.llm.groq_client import get_groq_llm
from src.config.settings import settings
from src.common.logger import get_logger
from src.common.custom_exception import CustomException
import time
import random


class QuestionGenerator:
    def __init__(self):
        self.llm = get_groq_llm()
        self.logger = get_logger(self.__class__.__name__)

    def _retry_and_parse(self,prompt,parser,topic,difficulty):

        for attempt in range(settings.MAX_RETRIES):
            try:
                self.logger.info(f"Generating question for topic {topic} with difficulty {difficulty} (Attempt {attempt + 1}/{settings.MAX_RETRIES})")

                response = self.llm.invoke(prompt.format(topic=topic , difficulty=difficulty))

                parsed = parser.parse(response.content)

                self.logger.info("Successfully parsed the question")

                return parsed
            
            except Exception as e:
                error_str = str(e)
                self.logger.error(f"Error on attempt {attempt + 1}: {error_str}")
                
                # Check if it's an API key error
                if "401" in error_str or "Invalid API Key" in error_str:
                    self.logger.warning("API key error detected. This might be a temporary issue.")
                    if attempt < settings.MAX_RETRIES - 1:
                        # Add exponential backoff with jitter for API key errors
                        wait_time = (2 ** attempt) + random.uniform(0, 1)
                        self.logger.info(f"Waiting {wait_time:.1f} seconds before retry...")
                        time.sleep(wait_time)
                        # Reinitialize the LLM client in case of API key issues
                        self.llm = get_groq_llm()
                        continue
                
                # For other errors, add a shorter delay
                elif attempt < settings.MAX_RETRIES - 1:
                    wait_time = 1 + random.uniform(0, 0.5)
                    self.logger.info(f"Waiting {wait_time:.1f} seconds before retry...")
                    time.sleep(wait_time)
                    continue
                
                # If this is the last attempt, raise the exception
                if attempt == settings.MAX_RETRIES - 1:
                    raise CustomException(f"Generation failed after {settings.MAX_RETRIES} attempts", e)
                
    
    def generate_mcq(self,topic:str,difficulty:str='medium') -> MCQQuestion:
        try:
            parser = PydanticOutputParser(pydantic_object=MCQQuestion)

            question = self._retry_and_parse(mcq_prompt_template,parser,topic,difficulty)

            # Fix: Ensure we have exactly 4 options and correct answer is in options
            if len(question.options) != 4:
                # If we don't have 4 options, try to fix it
                if len(question.options) < 4:
                    # Add dummy options if we have fewer than 4
                    dummy_options = ["Option A", "Option B", "Option C", "Option D"]
                    while len(question.options) < 4:
                        question.options.append(dummy_options[len(question.options)])
                elif len(question.options) > 4:
                    # Take only first 4 options
                    question.options = question.options[:4]
            
            # Ensure correct answer is in options
            if question.correct_answer not in question.options:
                # If correct answer is not in options, replace first option
                question.options[0] = question.correct_answer
            
            self.logger.info("Generated a valid MCQ Question")
            return question
        
        except Exception as e:
            self.logger.error(f"Failed to generate MCQ : {str(e)}")
            raise CustomException("MCQ generation failed" , e)
        
    
    def generate_fill_blank(self,topic:str,difficulty:str='medium') -> FillBlankQuestion:
        try:
            parser = PydanticOutputParser(pydantic_object=FillBlankQuestion)

            question = self._retry_and_parse(fill_blank_prompt_template,parser,topic,difficulty)

            if "___" not in question.question:
                raise ValueError("Fill in blanks should contain '___'")
            
            self.logger.info("Generated a valid Fill in Blanks Question")
            return question
        
        except Exception as e:
            self.logger.error(f"Failed to generate fillups : {str(e)}")
            raise CustomException("Fill in blanks generation failed" , e)

