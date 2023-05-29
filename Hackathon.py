import argparse
import json
from supabase import create_client

def create_argument_parser():
    parser = argparse.ArgumentParser(description='Crypto exchange CLI')
    parser.add_argument('action', choices=['buy', 'sell'], help='The action to perform')
    parser.add_argument('--price', type=float, required=True, help='The price per unit for the order')
    parser.add_argument('--quantity', type=float, required=True, help='The quantity for the order')
    parser.add_argument('--symbol', type=str, required=True, help='The authentication symbol for the user')
    return parser
def connect_to_database():
    url = "https://zurfertwlcanxrxhxupr.supabase.co"
    key = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp1cmZlcnR3bGNhbnhyeGh4dXByIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODQ3MTQ5NjcsImV4cCI6MjAwMDI5MDk2N30.GLvgd2XlyJTQcIoYJu5G8s9NlxVZiODwDxWresIOOK0"
    supabase = create_client(url, key)
    return supabase

def create_order(supabase, action, price, quantity, symbol):
    response = supabase.table('cryptocurrencies').select('cryptoid').eq('cryptosymbol', symbol.upper()).execute()



    CryptoID = response.data[0]['cryptoid']

    data = {
        "cryptoid": CryptoID,
        "userid": 1,
        "ordertype": action.upper(),
        "quantity": quantity,
        "price": price,
        "status": 'OPEN'
    }
    response = supabase.table('orders').insert(data).execute()
    print (f"Order created successfully, when price reach {price} ; you will {action} {quantity} {symbol.upper()}")

def main():
    parser = create_argument_parser()

    while True:
        args = parser.parse_args(input("Enter your command (example: buy --symbol btc --price 100 --quantity 1):").split())
        supabase = connect_to_database()
        create_order(supabase, args.action, args.price, args.quantity, args.symbol)

if __name__ == '__main__':
    main()



