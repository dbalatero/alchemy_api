module AlchemyApi
  class Base < MonsterMash::Base
    defaults do
      cache_timeout 999999
      user_agent 'Ruby AlchemyApi'
    end
  end
end
