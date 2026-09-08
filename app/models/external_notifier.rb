class ExternalNotifier
    cattr_accessor :deliveries
    self.deliveries = []
    def self.notify(code)
        deliveries << code
    end
    def self.clear
        self.deliveries = []
    end
end