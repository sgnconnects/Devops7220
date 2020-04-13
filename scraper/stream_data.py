import json
import requests
from websocket import create_connection

socket_headers = json.dumps({
    'Accept-Encoding':'gzip deflat,br',
    'Accept-Language':'en-US,en;q=0.9,zh-TW;q=0.8,zh;q=0.7,zh-CN;q=0.6',
    'Cache-Control': 'no-cache',
    'Connection': 'Upgrade',
    'Host': 'streamer.finance.yahoo.com',
    'Origin': 'https://finance.yahoo.com',
    'Pragma': 'no-cache',
    'Sec-WebSocket-Extensions': 'permessage-deflate; client_max_window_bits',
    'Sec-WebSocket-Version': '13',
    'Upgrade': 'websocket',
    'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36'
})

decoder_headers = {
    "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36",
    "Accept": "*/*",
    "Cache-Control": "no-cache",
    "Host": "localhost:3000",
    "Accept-Encoding": "gzip, deflate",
    "Content-Length": "79",
    "Connection": "keep-alive",
    "Content-Type": "application/json"
}

coin = "ETH-USD"
print('{"subscribe": ["%s"]}' % (coin))

ws = create_connection('wss://streamer.finance.yahoo.com/', headers=socket_headers)
ws.send('{"subscribe": ["%s"]}' % (coin))


if __name__ == "__main__":
    while True:
        encoded_data  = ws.recv()
        body = {"encodedData": encoded_data}
        decoded_data = requests.post("http://localhost:3000/decode", data=json.dumps(body), headers=decoder_headers)
        print(decoded_data.json())
    ws.close()
