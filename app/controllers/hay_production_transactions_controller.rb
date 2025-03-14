class HayProductionTransactionsController < ApplicationController
	def index
    	@transactions = HayProductionTransactions.all
  	end
end
