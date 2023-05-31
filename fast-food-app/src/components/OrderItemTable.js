export default function OrderItemTable(props) {
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
                {props.orders.items?.map(item => {
                    return (
                    <tr>
                        <td>{item.OrderNumber}</td>
                        <td>{item.ItemName}</td>
                        <td>{item.Quantity}</td>
                        <td>{item.Modifications}</td>
                    </tr>);
                    })
                }
                </tbody>
            </table>
      </div>
    );
}