require 'rails_helper'

RSpec.describe Comment, type: :model do

  let(:movie) { FactoryBot.build(:movie) }
  let(:user) { User.new(email: "test@test.com", password: "justwritingtests")}

  subject { 
    described_class.new(
      text: "this is an example comment",
      user: user,
      movie: movie
    ) 
  }

  it { should belong_to(:movie) }
  it { should belong_to(:user) }

  it "isn't valid without comment text" do
    subject.text = nil
    expect(subject).not_to be_valid
  end

  it "isn't valid with blank comment text" do
    subject.text = ""
    expect(subject).not_to be_valid
  end

  it "isn't valid when the user's unknown" do
    subject.user = nil
    expect(subject).not_to be_valid
  end

  it "isn't valid when the movie's unknown" do
    subject.movie = nil
    expect(subject).not_to be_valid
  end

  context "an user should have only one comment for a movie" do
    before(:each) do 
      @u = User.create(email: "test@test.com", password: "justwritingtests") # no factory for User :(
      @m = FactoryBot.create(:movie)
      @u.comments << Comment.new(text: "a text comment passing through", movie: @m)
    end

    it "isn't valid if the user tries to comment on the same movie twice" do 
      cmnt = Comment.new(text: "another comment passing through", movie: @m, user: @u)
      expect(cmnt).not_to be_valid
    end
  end
end
