FROM joyzoursky/python-chromedriver:3.6-alpine3.7-selenium
WORKDIR /scraper
COPY yahoo-scraper.py ./yahoo-scraper.py
COPY requirements.txt ./requirements.txt
RUN ["pip3", "install", "-r", "requirements.txt"]
CMD ["python3", "yahoo-scraper.py"]
