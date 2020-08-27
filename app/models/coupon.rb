class Coupon
    @@coupon_hash = {"DEVSINC": ".5", "PAKARMY": ".3"}

    def self.coupon_hash
        @@coupon_hash
    end
end