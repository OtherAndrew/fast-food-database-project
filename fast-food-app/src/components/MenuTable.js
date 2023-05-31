export default function MenuTable(props) {
  if (props.menu.combos) {
    return (
      <div className="table">
        {props.loading
          ? (
            <div>Loading...</div>
          )
          : (
            <table border={1}>
              <tbody>
                <tr>
                  <th>Combo #</th>
                  <th>Combo</th>
                  <th>Entree</th>
                  <th>Side</th>
                  <th>Drink</th>
                  <th>Calories</th>
                  <th>Price</th>
                </tr>
                {props.menu.combos?.map(item => {
                  return (
                    <tr key={item.ComboNumber}>
                      <td>{item.ComboNumber}</td>
                      <td>{item.ComboName}</td>
                      <td>{item.Entree}</td>
                      <td>{item.Side}</td>
                      <td>{item.Drink}</td>
                      <td>{item.Calories}</td>
                      <td>{'$' + item.Price}</td>
                    </tr>);
                  })
                }
              </tbody>
            </table>
          )
        }
      </div>
    );
  } else {
    return (
      <div className="table">
        {props.loading
          ? (
            <div>Loading...</div>
          )
          : (
            <table border={1}>
              <tbody>
              <tr>
                <th>Item #</th>
                <th>Item</th>
                <th>Calories</th>
                <th>Price</th>
              </tr>
              {props.menu.items?.map(item => {
                return (
                  <tr key={item.ItemNumber}>
                    <td>{item.ItemNumber}</td>
                    <td>{item.ItemName}</td>
                    <td>{item.Calories}</td>
                    <td>{'$' + item.Price}</td>
                  </tr>);
                })
              }
              </tbody>
            </table>
          )
        }
      </div>
    );
  }
}

