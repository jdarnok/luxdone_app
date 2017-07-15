FactoryGirl.define do
  factory :country do
    trait :poland do
      name 'Poland'
      twitter_id 'd9074951d5976bdf'
    end
    trait :germany do
      name 'Germany'
      twitter_id 'fdcd221ac44fa326'
    end
    trait :japan do
      name 'Japan'
      twitter_id '06ef846bfc783874'
    end
  end
end
