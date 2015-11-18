class ImporterController < ApplicationController
  skip_authorization_check
  skip_before_action :authenticate_user!

  def index
  end

  def import
    rowarray = Array.new
    myfile = params[:file]

    myfile.pry

    CSV.foreach(myfile.path) do |row|
      rowarray << row
      @rowarraydisp = rowarray
    end

    @rowarraydisp.each do |row|
      nn = Newsletter.where(name: row[0])
      if nn.count == 0
        n = Newsletter.new(name: row[0], url: row[1])
        n.tag_list = row[2]
        n.save
      end
    end
  end
end
