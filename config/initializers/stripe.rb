Rails.configuration.stripe = {
    publishable_key: ENV['pk_test_51HL27CHCd5LMgwIMzHXo0wEPWejhxGiZJU41f4Ay8uuLLJDgqKW5tvyeAsfNVJdOs1lG3Ydr2fQqsRN5e4aqcd7C00ftwWhoH4'],
    secret_key: ENV['sk_test_51HL27CHCd5LMgwIM98sqapqsMkGNKIpGSC7rwTJrMqQw6VmvPanK5AQqxvvrsUmhkILkQ8bLuBDOGV6vESKB12iD00ofys5t9x']
  }
  
Stripe.api_key = Rails.configuration.stripe[:secret_key]