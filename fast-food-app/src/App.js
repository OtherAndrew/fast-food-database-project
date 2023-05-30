import banner from './Banner.png'
import {useReducer, useState, useEffect, React} from 'react'
import './App.css';
import Table from './Table';
import menuData from './menu.json';
//Help from tutorials: https://www.digitalocean.com/community/tutorials/how-to-build-forms-in-react


const formReducer = (state, event) => {
  if(event.reset) {
    return {
      // item: '',
      // count: '',
      // name: '',
      // changes:'',
      //'gift-wrap': false,
    }
  }
  return {
    ...state,
    [event.name]: event.value
  }
}


function App() {
  const [itemData, setItemData] = useReducer(formReducer, {});
  const [orderData, setOrderData] = useReducer(formReducer, {});
  const [orderItem, setOrderItem] = useState([]);

  const [filter, setFilter] = useState('');

  const [menu, setMenu] = useState([])
  const [loading, setLoading] = useState(false)

  const [submitting, setSubmitting] = useState(false);

  const handleItemSubmit = event => {
    event.preventDefault();
    setOrderItem([
      ...orderItem,
      {
        customer: orderData.name,
        item: itemData.item,
        count: itemData.count,
        changes: itemData.changes,
        store: orderData.store,
        payment: orderData.payment
      }
    ]);
    setItemData({
      reset: true
    })
  }

  const handleOrderChange = event => {
    setOrderData({
      name: event.target.name,
      value:event.target.value,
    });
  }
  const handleItemChange = event => {
    setItemData({
      name: event.target.name,
      value:event.target.value,
    });
  }
  const handleFilterChange = event => {
    // console.log(event.target.value)
    // setFilter({
    //   filter: event.target.value,
    // });
    fetch('http://localhost:5000/menu/' + event.target.value, {
      method: "GET", // *GET, POST, PUT, DELETE, etc.
      mode: "cors", // no-cors, *cors, same-origin
    })
        .then(response => response.json())
        .then(response => setMenu(response))
        .finally(() => {
          setLoading(false)
        })
  }


  useEffect(() => {
    setLoading(true)
    fetch('http://localhost:5000/menu/' + filter, {
        method: "GET", // *GET, POST, PUT, DELETE, etc.
        mode: "cors", // no-cors, *cors, same-origin
    })
      .then(response => response.json())
      .then(response => setMenu(response))
      .finally(() => {
        setLoading(false)
      })
  }, [])
  console.log(menu)
  return(
    <div className = "wrapper">
      <header className='banner'> 
        <h1>Burger Shrine</h1>
        <img src = {banner} alt = {'Tasty burger'}/>
      </header>
      <header className='orders'>
        <div>
          <h1>Menu</h1>
          <select name="name" onChange={handleFilterChange}>
                  <option value="">All</option>
                  <option value='entrees'>Entrees</option>
                  <option value='sides'>Sides</option>
                  <option value='Drinks'>Drinks</option>
                  <option value='Combos'>Combos</option>
                  <option value='Vegetarian'>Vegetarian</option>
          </select>
            <div className="table">
            {loading ? (
              <div>Loading...</div>
            ) : (
              <>
                <table border={1}>
                  <tr>
                    <th>Item #</th>
                    <th>Item</th>
                    <th>Price</th>
                  </tr>
                      {menu.items?.map (item => {
                        return (
                          <tr>
                          <td>{item.ItemNumber}</td>
                          <td>{item.ItemName}</td>
                          <td>{item.Price}</td>
                          </tr>
                        )
                      }
                      )}

                </table>
              </>
            )}
          </div>
        </div>
        <div>
          <form onSubmit={handleItemSubmit}>
            <h2>Order Information:</h2>
            <fieldset> 
              <label> 
                <p>Select Customer</p>
                <select name="name" onChange={handleOrderChange}>
                  <option value="">--Please choose an option--</option>
                  <option value='Hakurei Reimu'>Hakurei Reimu</option>
                  <option value='Kochiya Sanae'>Kochiya Sanae</option>
                </select>
                <p>Select Store</p>
                <select name="store" onChange={handleOrderChange}>
                  <option value="">--Please choose an option--</option>
                  <option value='Geidontei'>Geidontei</option>
                  <option value='Yosuzume Izakaya'>Yosuzume Izakaya</option>
                </select>
                <p>Select Payment Type</p>
                <select name="payment" onChange={handleOrderChange}>
                  <option value="">--Please choose an option--</option>
                  <option value="creditcard">Credit Card</option>
                  <option value="cash">Cash</option>
                  <option value="rewards">Rewards</option>
                  <option value="giftcard">Gift Card</option>
                  
                </select>
              </label>
            </fieldset>
          </form>
        </div>
        <form onSubmit={handleItemSubmit}>
          <h2>Please select items</h2>
          <fieldset disabled={submitting}>
            <h3>Add an item:</h3>
          <label>
            <p>Item</p>
            <select name="item" onChange={handleItemChange} value={itemData.item || ''}>

              <option value="">--Please choose an option--</option>
              {menuData.items.map((option) => (
              <option value={option.itenName}>{option.ItemName}</option>
              ))}
              
            </select>
          </label>
          <label>
            <p>Count</p>
            <input type="number" name="count" onChange={handleItemChange} step="1" value={itemData.count || ''}/>
          </label>

          <label> 
            <p>Changes (Optional)</p>
            <input name = "changes" onChange={handleItemChange} value={itemData.changes || ''}/>
          </label>
        </fieldset>
          <button type = 'submit' disabled={submitting||!itemData.item||!itemData.count}>
            Add to order</button>
        </form>
        {<div>
          <h1>Customer Info:</h1>
          <ul>
            {Object.entries(orderData).map(([name, value]) => (
              <li key={name}><strong>{name}</strong>: {value.toString()}</li>
            ))}
          </ul>
          <h1>Current Order:</h1>
          <ul>
            {orderItem.map(orderItem => (
              <li key={orderItem.item}>(<strong>{orderItem.count}</strong>) {orderItem.item}</li>
            ))}
            <li>OrderTotal: </li>
          </ul>
        </div>}
        </header>
    </div>
  );

}

//Checkbox template
{/* <label>
  <p>Gift Wrap</p>
  <input type="checkbox" name="gift-wrap" onChange={handleItemChange} value={itemData.['gift-wrap'] || false}/>
</label> */}
export default App;
