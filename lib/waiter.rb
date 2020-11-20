class Waiter

    attr_accessor :name, :yrs_experience

    @@all = []

    def initialize(name, yrs_experience)
        @name = name
        @yrs_experience = yrs_experience
        @@all << self
    end

    def self.all
        @@all
    end
    
    def new_meal(customer, total, tip=0)
        Meal.new(self, customer, total, tip)
    end

    def meals
        Meal.all.select {|meal| meal.waiter == self}
    end

    def best_tipper
        best_tipped_meal = meals.max do |meal_a, meal_b|
            meal_a.tip <=> meal_b.tip
        end

        best_tipped_meal.customer
    end

    def most_freq_customer
        customer_count = {}
        key_max = nil
        val_max = 0
        meals.each do |meal|
            if customer_count.has_key?(meal.customer.name)
                customer_count[meal.customer.name] += 1
            else
                customer_count[meal.customer.name] = 1
            end
        end
        customer_count
        customer_count.each do |k, v|
            if v > val_max
                val_max = v
                key_max = k
            else
                val_max
                key_max
            end
        end
        key_max
    end

    def worst_tippers_meal
        worst_tipped_meal = meals.min do |meal_a, meal_b|
            meal_a.tip <=> meal_b.tip
        end

    end

    def self.average_tips_most_experienced
        most_experienced_waiter = self.all.max do |waiter_a, waiter_b|
            waiter_a.yrs_experience <=> waiter_b.yrs_experience
        end
        num_of_meals = 0
        tips_total = 0
        most_experienced_waiter.meals.each do |meal|
            num_of_meals += 1
            tips_total =+ meal.tip
        end
        average = tips_total / num_of_meals
    end

    def self.average_tips_least_experienced
        least_experienced_waiter = self.all.min do |waiter_a, waiter_b|
            waiter_a.yrs_experience <=> waiter_b.yrs_experience
        end
        num_of_meals = 0
        tips_total = 0
        least_experienced_waiter.meals.each do |meal|
            num_of_meals += 1
            tips_total =+ meal.tip
        end
        average = tips_total / num_of_meals
    end

end