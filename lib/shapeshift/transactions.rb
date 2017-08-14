module Shapeshift
  # Network Layer for API Rest client
  module TransactionClient

    # url:  shapeshift.io/shift
    # method: POST
    # data type: JSON
    # data required:
    # withdrawal     = the address for resulting coin to be sent to
    # pair       = what coins are being exchanged in the form [input coin]_[output coin]  ie btc_ltc
    # returnAddress  = (Optional) address to return deposit to if anything goes wrong with exchange
    # destTag    = (Optional) Destination tag that you want appended to a Ripple payment to you
    # rsAddress  = (Optional) For new NXT accounts to be funded, you supply this on NXT payment to you
    # apiKey     = (Optional) Your affiliate PUBLIC KEY, for volume tracking, affiliate payments, split-shifts, etc...     
    # Success Output:
    #     {
    #         deposit: [Deposit Address (or memo field if input coin is BTS / BITUSD)],
    #         depositType: [Deposit Type (input coin symbol)],
    #         withdrawal: [Withdrawal Address], //-- will match address submitted in post
    #         withdrawalType: [Withdrawal Type (output coin symbol)],
    #         public: [NXT RS-Address pubkey (if input coin is NXT)],
    #         xrpDestTag : [xrpDestTag (if input coin is XRP)],
    #         apiPubKey: [public API attached to this shift, if one was given]
    #     }  
    def shift( withdrawal, pair, opts = {} )
      body = { withdrawal: withdrawal, pair: pair }
      body.merge!( opts )
      post("/shift", { body: body } )
    end

    # url:  shapeshift.io/mail
    # method: POST
    # data type: JSON
    # data required:
    # email    = the address for receipt email to be sent to
    # txid       = the transaction id of the transaction TO the user (ie the txid for the withdrawal NOT the deposit)
    # example data {"email":"mail@example.com", "txid":"123ABC"}
    def mail( email, txid )
      body = { email: email, txid: txid }
      post("/mail", { body: body } )
    end

    # url: shapeshift.io/sendamount
    # method: POST
    # data type: JSON

    # 1. Send amount request
    #
    # Data required:
    # amount          = the amount to be sent to the withdrawal address
    # withdrawal      = the address for coin to be sent to
    # pair            = what coins are being exchanged in the form [input coin]_[output coin]  ie ltc_btc
    # returnAddress   = (Optional) address to return deposit to if anything goes wrong with exchange
    # destTag         = (Optional) Destination tag that you want appended to a Ripple payment to you
    # rsAddress       = (Optional) For new NXT accounts to be funded, supply this on NXT payment to you
    # apiKey          = (Optional) Your affiliate PUBLIC KEY, for volume tracking, affiliate payments, split-shifts, etc...
    # {
    #      success:
    #       {
    #         pair: [pair],
    #         withdrawal: [Withdrawal Address], //-- will match address submitted in post
    #         withdrawalAmount: [Withdrawal Amount], // Amount of the output coin you will receive
    #         deposit: [Deposit Address (or memo field if input coin is BTS / BITUSD)],
    #         depositAmount: [Deposit Amount], // Exact amount of input coin to send in
    #         expiration: [timestamp when this will expire],
    #         quotedRate: [the exchange rate to be honored]
    #         apiPubKey: [public API attached to this shift, if one was given]
    #       }
    # }
    def send_amount( withdrawal, pair, amount, opts = {} )
      body = { withdrawal: withdrawal, pair: pair, amount: amount }
      body.merge!( opts )
      post("/sendamount", { body: body })
    end

    # 2. Quoted Price request
    # 
    # Note :  This request will only return information about a quoted rate
    #         This request will NOT generate the deposit address.
    #   Data required:
    # amount  = the amount to be sent to the withdrawal address
    # pair    = what coins are being exchanged in the form [input coin]_[output coin]  ie ltc_btc
    # {
    #      success:
    #       {
    #         pair: [pair],
    #         withdrawalAmount: [Withdrawal Amount], // Amount of the output coin you will receive
    #         depositAmount: [Deposit Amount], // Exact amount of input coin to send in
    #         expiration: [timestamp when this will expire],
    #         quotedRate: [the exchange rate to be honored]
    #         minerFee: [miner fee for this transaction]
    #       }
    # }
    def quote_price( pair, amount )
      body = { pair: pair, amount: amount }
      post("/sendamount", { body: body })
    end


    # url: shapeshift.io/cancelpending
    # method: POST
    # data type: JSON
    # data required: address  = The deposit address associated with the pending transaction
    def cancel( address )
      body = { address: address }
      post("/cancelpending", { body: body } )
    end

  end
end