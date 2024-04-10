class SheetsController < ApplicationController
  # GET /sheets or /sheets.json
  def index
    @sheets = Sheet.all
  end
end
