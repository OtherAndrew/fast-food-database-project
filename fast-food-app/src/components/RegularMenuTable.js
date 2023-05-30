export default function RegularMenuTable(props) {
  return (
    <div className="table">
      {props.loading
        ? (<div>Loading...</div>)
        : (
          <table border={1}>
            <tbody>
              <tr>
                <th>Item #</th>
                <th>Item</th>
                <th>Price</th>
              </tr>
              {props.menu.items?.map (item => {
                  return (
                    <tr key={item.ItemNumber}>
                      <td>{item.ItemNumber}</td>
                      <td>{item.ItemName}</td>
                      <td>{item.Price}</td>
                    </tr>
                  )
                }
              )}
            </tbody>
          </table>
        )
      }
    </div>
  );
}

