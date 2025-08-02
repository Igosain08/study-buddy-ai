from setuptools import setup,find_packages

with open("requirements.txt") as f:
    requirements = f.read().splitlines()

setup(
    name="study-buddy-ai",
    version="0.1",
    author="Your Name",
    packages=find_packages(),
    install_requires = requirements,
)