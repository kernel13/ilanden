
FactoryGirl.define do
  factory :note, :class => Refinery::Notes::Note do
    sequence(:name) { |n| "refinery#{n}" }
  end
end

