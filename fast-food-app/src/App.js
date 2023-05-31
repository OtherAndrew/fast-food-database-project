import banner from './Banner.png'
import {useReducer, useState, useEffect, React} from 'react'
import './App.css';
import Table from './Table';
import menuData from './menu.json';
import MenuTable from "./components/MenuTable";
import SelectBox from "./components/SelectBox";

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


  const [menu, setMenu] = useState([])
  const [stores, setStores] = useState([])
  const [customers, setCustomers] = useState([])
  const [addresses, setAddresses] = useState([])
  const [loading, setLoading] = useState(false)

  const [submitting, setSubmitting] = useState(false);

  const handleItemSubmit = event => {
    event.preventDefault();
    setOrderItem([
      ...orderItem,
      {
        customerID: orderData.customerID,
        address: orderData.address,
        item: itemData.item,
        count: itemData.count,
        changes: itemData.changes,
        store: orderData.store,
        payment: orderData.payment,
        pickup: orderData.pickup
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
  const handleCustomerChange = event => {
    setOrderData({
      name: event.target.name,
      value:event.target.value,
    });
    fetch('http://localhost:5000/customers/address?id=' + event.target.value, {
      method: "GET", // *GET, POST, PUT, DELETE, etc.
      mode: "cors", // no-cors, *cors, same-origin
    })
        .then(response => response.json())
        .then(response => setAddresses(response))
        .finally(() => {
          setLoading(false)
        })
  }

  useEffect(() => {
    setLoading(true)
    //MENU
    fetch('http://localhost:5000/menu/', {
        method: "GET", // *GET, POST, PUT, DELETE, etc.
        mode: "cors", // no-cors, *cors, same-origin
    })
      .then(response => response.json())
      .then(response => setMenu(response))
      .finally(() => {
        setLoading(false)
      })
    //STORES
    fetch('http://localhost:5000/info/stores', {
        method: "GET", // *GET, POST, PUT, DELETE, etc.
        mode: "cors", // no-cors, *cors, same-origin
    })
      .then(response => response.json())
      .then(response => setStores(response))
      .finally(() => {
        setLoading(false)
      })
    //Customers
    fetch('http://localhost:5000/customers', {
      method: "GET", // *GET, POST, PUT, DELETE, etc.
      mode: "cors", // no-cors, *cors, same-origin
  })
    .then(response => response.json())
    .then(response => setCustomers(response))
    .finally(() => {
      setLoading(false)
    })
  }, [])
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
            <option value='combos'>Combos</option>
            <option value='entrees'>Entrees</option>
            <option value='sides'>Sides</option>
            <option value='drinks'>Drinks</option>
            <option value='vegetarian'>Vegetarian</option>
          </select>
          <MenuTable
            loading={loading}
            menu={menu}
            />
        </div>
        <div>
          <form onSubmit={handleItemSubmit}>
            <h2>Order Information:</h2>
            <fieldset> 
              <label> 
                <p>Select Customer</p>
                <SelectBox handle={handleCustomerChange} name='customerID'
                  options = {customers.customers?.map((option) => (
                    <option value={option.CustomerID}>{option.Name}</option>
                   ))}/>
                <p>Select Customer Address</p>
                <SelectBox handle={handleOrderChange} name='address' disabled = {!orderData.customerID}
                  options = {addresses.addresses?.map((option) => (
                    <option value={option.StreetAddress}>{option.StreetAddress + ' ' + option.City}</option>
                   ))}/>
                <p>Select Store</p>
                <SelectBox handle={handleOrderChange} name='store'
                  options = {stores.stores?.map((option) => (
                    <option value={option.StoreNumber}>{option.StreetAddress + ' ' + option.City}</option>
                   ))}/>
                <p>Select Payment Type</p>
                <select name="payment" onChange={handleOrderChange}>
                  <option value="">--Please choose an option--</option>
                  <option value="creditcard">Credit Card</option>
                  <option value="cash">Cash</option>
                  <option value="rewards">Rewards</option>
                  <option value="giftcard">Gift Card</option>
                </select>
                <p>Select Pickup Method</p>
                <select name="pickup" onChange={handleOrderChange}>
                  <option value="">--Please choose an option--</option>
                  <option value="Dine in">Dine-in</option>
                  <option value="Drive-thru">Drive-thru</option>
                  <option value="Walk in">Walk in</option>
                  <option value="Delivery">Delivery</option>
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
            <SelectBox handle={handleItemChange} name='item' value={itemData.item || ''}
              options = {
                menu.combos 
                ? (
                  menu.combos?.map((option) => (
                    <option value={option.ComboName}>{option.ComboName}</option>
                  ))
                ) 
                : (
                  menu.items?.map((option) => (
                    <option value={option.ItemName}>{option.ItemName}</option>
                  ))
                )}/>
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
