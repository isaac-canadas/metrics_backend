require 'rails_helper'

RSpec.describe "Metrics API", type: :request do
  # initialize test data
  let!(:metrics) { create_list(:metric, 10) }
  let(:metric_id) { metrics.first.id }

  # Test suite for GET /metrics
  describe 'GET /metrics' do
    # make HTTP get request before each example
    before { get '/metrics' }

    it 'returns metrics' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /metrics/:id
  describe 'GET /metrics/:id' do
    before { get "/metrics/#{metric_id}" }

    context 'when the record exists' do
      it 'returns the metric' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(metric_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:metric_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Metric/)
      end
    end
  end

  # Test suite for POST /metrics
  describe 'POST /metrics' do
    # valid payload
    let(:valid_attributes) { { name: 'Learn Elm', value: '1' } }

    context 'when the request is valid' do
      before { post '/metrics', params: valid_attributes }

      it 'creates a metric' do
        expect(json['name']).to eq('Learn Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/metrics', params: { name: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Value can't be blank/)
      end
    end
  end

  # Test suite for PUT /metrics/:id
  describe 'PUT /metrics/:id' do
    let(:valid_attributes) { { name: 'Shopping' } }

    context 'when the record exists' do
      before { put "/metrics/#{metric_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /metrics/:id
  describe 'DELETE /metrics/:id' do
    before { delete "/metrics/#{metric_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
