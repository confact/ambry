require File.expand_path("../spec_helper", __FILE__)

describe Prequel::KeySet do

  before { load_fixtures }
  after  { Prequel.adapters.clear }

  describe "#+" do
    it "should add two key sets" do
      key_set = Person.find {|p| p.name =~ /Curly/} + Person.find {|p| p.name =~ /Larry/}
      assert_equal 2, key_set.length
    end

    it "should not duplicate entries" do
      key_set = Person.find {|p| p.name =~ /Curly/} + Person.find {|p| p.name =~ /Curly/}
      assert_equal 1, key_set.length
    end
  end

  describe "#-" do
    it "should subtract a key set" do
      key_set = Person.find - Person.find {|p| p.name =~ /Larry/}
      assert_equal 3, key_set.length
    end
  end

  describe "#&" do
    it "should get set intersection" do
      key_set = Person.find & Person.find {|p| p.name =~ /Larry/}
      assert_equal 1, key_set.length
    end
  end

  describe "#first" do
    it "should return the first matching instance when called with a block" do
      assert_equal "Curly Howard", Person.first {|p| p.name =~ /Curly/}.name
    end

    it "should return the first instance when not called with a block" do
      assert_kind_of Person, Person.first
    end
  end

  describe "#count" do
    it "should count matching instances when called with a block" do
      assert_equal 3, Person.count {|p| p.name =~ /Howard/}
    end

    it "should count all keys when called without a block" do
      assert_equal 4, Person.count
    end
  end

  describe "#find" do
    it "should return a KeySet of matching keys when called with a block" do
      key_set = Person.find {|p| p.name =~ /Larry/}
      assert_kind_of Prequel::KeySet, key_set
      assert_equal 1, key_set.size
    end

    it "should return a KeySet of all keys when called with no block" do
      assert_equal 4, Person.find.size
    end

    it "should yield an instance of HashProxy to the block" do
      Person.find {|x| assert_kind_of Prequel::HashProxy, x}
    end

    it "should be chainable" do
      assert_equal "Larry Fine", Person.stooges.non_howards.first.name
    end
    
    it "should raise error when trying to chain nonexistant method" do
      assert_raises NoMethodError do
        Person.stooges.foobar
      end
    end
    
  end

  describe "#find_by_key" do
    it "should yield a key to the block" do
      Person.find_by_key {|x| assert_kind_of String, x}
    end

    it "should return a KeySet of all keys when called with no block" do
      assert_equal 4, Person.find_by_key.size
    end
  end

  describe "#sort" do
    it "should sort" do
      assert_equal "clms", Person.find.sort {|a, b| a.name <=> b.name}.keys.map {|k| k[0]}.join
    end
  end

  describe "#limit" do
    it "should limit" do
      assert_equal 2, Person.find.limit(2).count
    end
  end
end