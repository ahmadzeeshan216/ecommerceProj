class StripeService
	attr_accessor :errors

    def initialize(params)
        @card_no = params[:card_no]
        @amount = params[:payable_amount]
		@security_code = params[:security_no]
		@errors = nil
    end
	
	def charge
		token =	Stripe::Token.create({
			card: {
				number: @card_no,
				exp_month: 8,
				exp_year: 2021,
				cvc: @security_code,
			},
		})

		customer = Stripe::Customer.create({
			source: token,
		})
		
		charge = Stripe::Charge.create({
			customer: customer.id,
			amount: @amount.to_i * 100,
			description: 'Rails Stripe customer',
			currency: 'usd',
		})

	rescue Stripe::CardError => e
		@errors = e.message
	end

end