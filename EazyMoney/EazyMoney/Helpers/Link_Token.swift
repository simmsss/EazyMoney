//
//  Link_Token.swift
//  EazyMoney
//
//  Created by Simran Gogia and Utkarsh Sharma on 29/11/20.
//

import Foundation


curl -X POST https://sandbox.plaid.com/link/token/create -H 'Content-Type: application/json' -d '{
  "client_id": "5fc24748dc2f2a0011702b4d",
  "secret": "30f6146f4c1ad1a1e9119e26fcae71",
  "user": {    "client_user_id": "skhiearth",
  },
  "client_name": "EazyMoney",
  "products": ["auth", "transactions", "identity", "assets", "investments", "liabilities", "payment_initiation"],
  "country_codes": ["GB"],
  "language": "en",
  "account_filters": {
      "depository": {
          "account_subtypes": ["checking"]
      }
  }
}'
