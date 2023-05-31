export default function OrderTable(props) {
    return (
        <div>
            <table border={1}>
                <tbody>
                <tr>
                    <th>CustomerID</th>
                    <th>Item Name</th>
                    <th>Quantity</th>
                    <th>Modifications</th>
                </tr>
                {props.orders.orders?.map(item => {
                    return (
                    <tr key={item.OrderNumber}>
                        <td>{item.CustomerID}</td>
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