require 'will_paginate/array'

class IdentitiesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :block_inactive_user!
  respond_to :json
  include ApplicationHelper

end