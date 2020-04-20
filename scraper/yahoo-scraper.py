import requests
from bs4 import BeautifulSoup
import pymongo
import uuid
from selenium import webdriver
import click
import os

# MongoDB Configuration
mongodb_url = "mongodb+srv://"+os.environ['MONGODB_USR']+":"+os.environ['MONGODB_PWD']+"@cyril-spa-zudqm.mongodb.net/Devops7220?retryWrites=true&w=majority"
print(mongodb_url)
client = pymongo.MongoClient(mongodb_url, 27017)
db = client.Devops7220
collection = db.crypto_currencies


def parser(tr, range, interval):
    tds = tr.find_all("td")
    coin = {}
    try:
        coin["img"] = tds[0].img.attrs["src"]
        coin["acronym"] = tds[0].a.string
        coin["name"] = tds[1].contents[1]
        coin["price"] = tds[2].string
        coin["change"] = tds[3].string
        coin["change_%"] = tds[4].string
        coin["market_cap"] = tds[5].string
        coin["vol_24h"] = tds[7].contents[1]
        coin["circulating_supply"] = tds[9].contents[1]

        data_link = "https://finance.yahoo.com/quote/" + coin["acronym"] + "/profile?p=" + coin["acronym"]
        # chart_link = "https://query1.finance.yahoo.com/v8/finance/chart/"+coin["acronym"]+"?symbol="+coin["acronym"]+"&range=1mo&interval=1d&includePrePost=true&events=div%7Csplit%7Cearn&lang=en-US&region=US&crumb=%2FZWzS8eH9Sq&corsDomain=finance.yahoo.com"
        chart_link = "https://query1.finance.yahoo.com/v8/finance/chart/" + coin["acronym"] + "?symbol=" + coin[
            "acronym"] + "&range=" + range + "&interval=" + interval + "&includePrePost=true&events=div%7Csplit%7Cearn&lang=en-US&region=US&crumb=%2FZWzS8eH9Sq&corsDomain=finance.yahoo.com"

        coin["_id"] = uuid.uuid5(uuid.NAMESPACE_URL, data_link)
        coin["coin_id"] = uuid.uuid5(uuid.NAMESPACE_URL, data_link)

        coin_data_1 = scrape_currency_data(data_link)
        coin_data_2 = scrape_chart_data(chart_link)

        coin.update(coin_data_1)
        coin.update(coin_data_2)
    except Exception as e:
        print(e)

    print(coin["name"])

    item = collection.find_one({"_id": coin["_id"]})
    if item == None:
        collection.insert_one(coin)
    else:
        collection.update_one({"_id": coin["_id"]}, {"$set": coin}, upsert=True)


def scrape_currency_data(link):
    data = {}
    response = requests.get(link)
    soup = BeautifulSoup(response.content, 'html.parser')
    try:
        data["about"] = soup.find("div", {"data-test": "prof-desc"}).text
        data["website"] = soup.find_all("table")[0].contents[0].contents[-1].text.split(": ")[1]
    except Exception as e:
        print(e)
    return data


def scrape_chart_data(link):
    data = {}
    response = requests.get(link)
    temp = response.json()
    try:
        data["chart_timestamps"] = temp["chart"]["result"][0]["timestamp"]
        data["chart_lows"] = temp["chart"]["result"][0]["indicators"]["quote"][0]["low"]
        data["chart_highs"] = temp["chart"]["result"][0]["indicators"]["quote"][0]["high"]
        data["chart_volumes"] = temp["chart"]["result"][0]["indicators"]["quote"][0]["volume"]
        data["chart_opens"] = temp["chart"]["result"][0]["indicators"]["quote"][0]["open"]
        data["chart_closes"] = temp["chart"]["result"][0]["indicators"]["quote"][0]["close"]
    except Exception as e:
        print(e)
    return data


def scrape_currencies_page(driver, range, interval):
    currencies_url = "https://finance.yahoo.com/cryptocurrencies"
    driver.get(currencies_url)
    html = driver.page_source
    soup = BeautifulSoup(html, 'html.parser')
    tr_list = soup.find_all("table")[0].tbody.find_all("tr")

    for coin_tr in tr_list:
        parser(tr=coin_tr, range=range, interval=interval)


@click.command()
@click.option('--range', '-r', default="1mo", help='Number of Crypto Currencies per page')
@click.option('--interval', '-i', default="1d", help='Number of Crypto Currencies per page')
def main(range, interval):
    chrome_options = webdriver.ChromeOptions()
    chrome_options.add_argument('--no-sandbox')
    chrome_options.add_argument('--window-size=1420,1080')
    chrome_options.add_argument('--headless')
    chrome_options.add_argument('--disable-gpu')
    driver = webdriver.Chrome(chrome_options=chrome_options)
    scrape_currencies_page(driver=driver, range=range, interval=interval)


if __name__ == "__main__":
    print("scraping Yahoo finance website")
    main()
