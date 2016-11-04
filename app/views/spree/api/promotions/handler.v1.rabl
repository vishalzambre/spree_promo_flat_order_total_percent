object false
node(:success) { @handler.success }
node(:error) { @handler.error }
node(:successful) { @handler.successful? }
node(:status_code) { @handler.status_code }
node(:free_order) { @order.flat_percent_order? }
