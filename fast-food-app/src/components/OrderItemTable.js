/**
 * Returns a table of items on order.
 * @param props Items on order.
 * @return {JSX.Element} A table of items on order.
 * @constructor
 */
export default function OrderItemTable(props) {
  const listItems = props.orders.items?.map(item =>
    <tr>
      <td>{item.OrderNumber}</td>
      <td>{item.ItemName}</td>
      <td>{item.Quantity}</td>
      <td>{item.Modifications}</td>
    </tr>
  );

  return (
    <div>
      <table border={1}>
        <tbody>
          <tr>
            <th>OrderID</th>
            <th>Item Name</th>
            <th>Quantity</th>
            <th>Modifications</th>
          </tr>
          {listItems}
        </tbody>
      </table>
  </div>
  );
}