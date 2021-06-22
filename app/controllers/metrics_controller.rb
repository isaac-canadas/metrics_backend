class MetricsController < ApplicationController
  before_action :set_metric, only: [:show, :update, :destroy]

  # GET /metrics
  def index
    @metrics = Metric.all
    json_response(@metrics)
  end

  # POST /metrics
  def create
    @metric = Metric.create!(metric_params)
    json_response(@metric, :created)
  end
  
  # GET /todos/:id
  def show
    json_response(@metric)
  end

  # PUT /metrics/:id
  def update
    @metric.update(metric_params)
    head :no_content
  end

  # DELETE /metrics/:id
  def destroy
    @metric.destroy
    head :no_content
  end

  # GET /metrics/average_day
  def average_day
    @metrics = Metric.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).group(:name).average(:value)
    json_response(@metrics)
  end

  # GET /metrics/average_hour
  def average_hour
    @metrics = Metric.where(created_at: Time.zone.now.beginning_of_hour..Time.zone.now.end_of_hour).group(:name).average(:value)
    json_response(@metrics)
  end

  # GET /metrics/average_minute
  def average_minute
    @metrics = Metric.where(created_at: Time.zone.now.beginning_of_minute..Time.zone.now.end_of_minute).group(:name).average(:value)
    json_response(@metrics)
  end

  private

  def metric_params
    # whitelist params
    params.permit(:name, :value)
  end

  def set_metric
    @metric = Metric.find(params[:id])
  end
end
