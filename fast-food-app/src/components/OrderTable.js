export default function OrderTable(props) {
  const listItems = props.orders.orders?.map(item =>
      <tr key={item.OrderNumber}>
        <td>{item.OrderNumber}</td>
        <td>{item.StoreNumber}</td>
        <td>{item.CustomerID}</td>
        <td>{item.PickupMethod}</td>
        <td>{item.PaymentMethod}</td>
        <td>{item.OrderTime}</td>
        <td>{'$' + item.OrderTotal}</td>
      </tr>
  );

  return (
    <div>
      <table border={1}>
        <tbody>
          <tr>
            <th>OrderID</th>
            <th>Store #</th>
            <th>Customer ID</th>
            <th>Pickup</th>
            <th>Payment</th>
            <th>Time</th>
            <th>Total</th>
          </tr>
          {listItems}
        </tbody>
      </table>
    </div>
  );
}