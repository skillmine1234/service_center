require 'will_paginate/array'

class AmlSearchController < ApplicationController
  before_filter :authenticate_user!
  before_filter :block_inactive_user!

  include ActionView::Helpers::TextHelper
  respond_to :html, :js, :json, :xml

  include ApplicationHelper

  def find_search_results
    if params[:search_params].present?
      if params[:search_params][:firstName].present? 
        @search_params = search_params(params[:search_params])
        results = get_response_from_api(CONFIG[:aml_search_url] + @search_params) rescue []
        @results_count = results.count rescue 0
        @results = results.paginate(:per_page => 10, :page => params[:page]) unless results.nil?
      else
        flash[:alert] = "First Name should not be empty"
      end
    end
  end

  def search_result
    results = get_response_from_api(CONFIG[:aml_search_url] + params[:search_params]) rescue []
    @result = results[params[:index].to_i] rescue nil
    identities = find_values(@result["identities"]["numIdentities"],@result["identities"]["identity"])
    @identities = identities.paginate(:per_page => 4, :page => params[:identities_page]) 
    aliases = find_values(@result["aliases"]["numAliases"],@result["aliases"]["alias"])
    @aliases = aliases.paginate(:per_page => 4, :page => params[:aliases_page]) 
    addresses = find_values(@result["addresses"]["numAddresses"] , @result["addresses"]["address"])
    @addresses = addresses.paginate(:per_page => 4, :page => params[:addresses_page]) 
  end

  def get_response_from_api(url)
    response = HTTParty.get(url)
    response.parsed_response["hits"]["hit"] rescue []
  end

  def search_params(params)
    result = ""
    params.each do |key,value|
      unless value.to_s.empty?
        result = result + key + "=" + value + "&"
      end
    end
    result[0...-1]
  end

  def find_values(num,values)
    if num == "0"
      return []
    elsif num == "1"
      return [values]
    else
      return values
    end
  end
end