FROM joyzoursky/python-chromedriver:3.6-alpine3.7-selenium
WORKDIR /scraper
COPY yahoo-scraper.py ./yahoo-scraper-selenium.py
COPY requirements.txt ./requirements-selenium.txt
RUN ["pip3", "install", "-r", "requirements-selenium.txt"]
CMD ["python3", "yahoo-scraper-selenium.py"]
