if Rails.env == 'development' || Rails.env == 'test'
  Stripe.api_key = 'sk_test_H1iue0XBXXmUYYayhDglzwwT'
  STRIPE_PUBLIC_KEY = 'pk_test_EVbocJQS2kNXUiZ92qY85evf'
elsif Rails.env == 'production'
  Stripe.api_key = 'sk_test_H1iue0XBXXmUYYayhDglzwwT'
  STRIPE_PUBLIC_KEY = 'pk_test_EVbocJQS2kNXUiZ92qY85evf'
  #Stripe.api_key = 'sk_live_THrcm1vt2uAJ5ofHge9bH90O'
  #STRIPE_PUBLIC_KEY = 'pk_live_KavW05auXwgQRJO2VWLmyGMC'
end
