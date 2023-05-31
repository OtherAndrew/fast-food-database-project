import banner from './Banner.png'
import {useReducer, useState, useEffect, React} from 'react'
import './App.css';
import MenuTable from "./components/MenuTable";
import SelectBox from "./components/SelectBox";
import OrderTable from "./components/OrderTable";
import OrderItemTable from "./components/OrderItemTable";

//Help from tutorials: https://www.digitalocean.com/community/tutorials/how-to-build-forms-in-react

function getAPI(URL, Set, Loading) {
  fetch(URL, {
    method: "GET", // *GET, POST, PUT, DELETE, etc.
    mode: "cors", // no-cors, *cors, same-origin
  })
    .then(response => response.json())
    .then(response => Set(response))
    .finally(() => {
      Loading(false)
  })
}
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
  const [itemEntry, setItemEntry] = useState([])
  const [allOrders, setAllOrders] = useState([])
  const [currentItems, setCurrentItems] = useState([])
  const [currentOrder, setCurrentOrder] = useState([])
  
  const [loading, setLoading] = useState(false)
  const [showHistory, setShowHistory] = useState(false);
  const [customerComplete, setCustomerComplete] = useState(false);

  const handleCustomerSubmit = event => {
    event.preventDefault();
    setCustomerComplete(true);
    //Post Order
    const data = {
      storeNumber: parseInt(orderData.store),
      customerID: parseInt(orderData.customerID),
      pickupMethod: orderData.pickup,
      paymentMethod: orderData.payment,
    }
    fetch('http://localhost:5000/orders/', {
      method: "POST", // *GET, POST, PUT, DELETE, etc.
      mode: "cors", // no-cors, *cors, same-origin
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(data)
    })
      .then(response => response.json())
      .then(response => {
        setOrderData({
          name: 'orderNumber',
          value: response.orderNumber
        });
        getAPI('http://localhost:5000/orders?orderNumber=' + response.orderNumber, setCurrentOrder, setLoading);
      })
      .finally(() => {
        getAPI('http://localhost:5000/orders/', setAllOrders, setLoading);
        setLoading(false)
      })

  }
  const handleItemSubmit = event => {
    event.preventDefault();
    setOrderItem([
      ...orderItem,
      {
        customerID: orderData.customerID,
        address: orderData.address,
        item: itemData.itemNumber,
        count: itemData.count,
        changes: itemData.changes,
        store: orderData.store,
        payment: orderData.payment,
        pickup: orderData.pickup
      }
    ]);
    //Post OrderItem
    const data = {
      orderNumber: parseInt(orderData.orderNumber),
      itemNumber: parseInt(itemData.itemNumber),
      quantity: parseInt(itemData.count),
      modifications: itemData.changes,
    }
    console.log(data)
    fetch('http://localhost:5000/orders/item', {
      method: "POST", // *GET, POST, PUT, DELETE, etc.
      mode: "cors", // no-cors, *cors, same-origin
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(data)
    })
      .finally(() => {
        getAPI('http://localhost:5000/orders/items', setItemEntry, setLoading);
        getAPI('http://localhost:5000/orders/', setAllOrders, setLoading);
        getAPI('http://localhost:5000/orders?orderNumber=' + orderData.orderNumber, setCurrentOrder, setLoading);
        getAPI('http://localhost:5000/orders/items?orderNumber=' + orderData.orderNumber, setCurrentItems, setLoading);
        setLoading(false)
      })

    setItemData({reset: true})
  }
  const handleShowHistory = event => {
    showHistory?setShowHistory(false):setShowHistory(true)
  }
  const handleNewCustomer = event => {
    setCustomerComplete(false)
    setOrderData({reset: true})
    setItemData({reset: true})
    setOrderItem([])
    setCurrentItems([])
    setCurrentOrder([])
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
    getAPI('http://localhost:5000/menu/' + event.target.value, setMenu, setLoading);
  }
  const handleCustomerChange = event => {
    setOrderData({
      name: event.target.name,
      value:event.target.value,
    });
    getAPI('http://localhost:5000/customers/address?id=' + event.target.value, setAddresses, setLoading);
  }

  useEffect(() => {
    document.title = 'Burger Shrine';
    setLoading(true)
    //MENU
    getAPI('http://localhost:5000/menu/', setMenu, setLoading);
    //STORES
    getAPI('http://localhost:5000/info/stores/', setStores, setLoading);
    //CUSTOMERS
    getAPI('http://localhost:5000/customers/', setCustomers, setLoading);
    //ITEM ENTRIES
    getAPI('http://localhost:5000/orders/items', setItemEntry, setLoading);
    //ORDER HISTORY
    getAPI('http://localhost:5000/orders/', setAllOrders, setLoading);
    //CURRENT ITEMS
    getAPI('http://localhost:5000/orders/', setCurrentItems, setLoading);
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
          <form onSubmit={handleCustomerSubmit}>
            <h2>Order Information:</h2>
            <fieldset disabled={customerComplete}> 
              <label> 
                <p>Select Customer</p>
                <SelectBox handle={handleCustomerChange} name='customerID' value={orderData.customerID || ''}
                  options = {customers.customers?.map((option) => (
                    <option value={option.CustomerID}>{option.Name}</option>
                   ))}/>
                <p>Select Customer Address</p>
                <SelectBox handle={handleOrderChange} name='address' disabled = {!orderData.customerID} value={orderData.address || ''}
                  options = {addresses.addresses?.map((option) => (
                    <option value={option.StreetAddress}>{`${option.StreetAddress} ${option.City} ${option.ZIP}`}</option>
                   ))}/>
                <p>Select Store</p>
                <SelectBox handle={handleOrderChange} name='store' value={orderData.store || ''}
                  options = {stores.stores?.map((option) => (
                    <option value={option.StoreNumber}>{`${option.StreetAddress} ${option.City} ${option.ZIP}`}</option>
                   ))}/>
                <p>Select Payment Type</p>
                <select name="payment" onChange={handleOrderChange} value={orderData.payment || ''}>
                  <option value="">--Please choose an option--</option>
                  <option value="Credit card">Credit Card</option>
                  <option value="Cash">Cash</option>
                  <option value="Rewards">Rewards</option>
                  <option value="Gift card">Gift Card</option>
                </select>
                <p>Select Pickup Method</p>
                <select name="pickup" onChange={handleOrderChange} value={orderData.pickup || ''}>
                  <option value="">--Please choose an option--</option>
                  <option value="Dine in">Dine-in</option>
                  <option value="Drive-thru">Drive-thru</option>
                  <option value="Walk in">Walk in</option>
                  <option value="Delivery">Delivery</option>
                </select>
              </label>
            </fieldset>
            {customerComplete ? 
            (<button onClick={handleNewCustomer}>New Order</button>) 
            : 
            (<button type='submit' 
              disabled={!orderData.address||!orderData.store||!orderData.payment||!orderData.pickup}>
              Start Order
            </button>
            )}
          </form>
        </div>
        <form onSubmit={handleItemSubmit}>
          <h2>Please select items</h2>
          <fieldset disabled = {!customerComplete}>
            <h3>Add an item:</h3>
          <label>
            <p>Item</p>
            <SelectBox handle={handleItemChange} name='itemNumber' value={itemData.itemNumber || ''}
              options = {
                menu.combos 
                ? (
                  menu.combos?.map((option) => (
                    <option value={option.ComboNumber}>{option.ComboName}</option>
                  ))
                ) 
                : (
                  menu.items?.map((option) => (
                    <option value={option.ItemNumber}>{option.ItemName}</option>
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
          <button type = 'submit' 
            disabled={!itemData.itemNumber||!itemData.count||!orderData.customerID||!orderData.store
            ||!orderData.payment||!orderData.pickup||!orderData.address}>
            Add to order</button>
        </form>
        {<div>
          <h1>Order Info:</h1>
          <OrderTable orders = {currentOrder}/>
          <h1>Current Order:</h1>
          <OrderItemTable orders = {currentItems}/>

          {/* <ul>
            {orderItem &&orderItem.map(orderItem => (
              <li>{orderData.CustomerID}{orderItem.item}(<strong>{orderItem.count}</strong>)</li>
            ))}
          </ul> */}
          <></>
        </div>}
        </header>
        <header><button onClick={handleShowHistory}>Show All Orders</button></header>
        {showHistory && <header className='orderHistory'>
          <div>
            <h1>All Orders</h1>
            <OrderTable orders = {allOrders}/>
          </div>
          <div>
            <h1>All Items on Orders</h1>
            <OrderItemTable orders = {itemEntry}/>
          </div>
        </header>}
    </div>
  );

}

//Checkbox template
{/* <label>
  <p>Gift Wrap</p>
  <input type="checkbox" name="gift-wrap" onChange={handleItemChange} value={itemData.['gift-wrap'] || false}/>
</label> */}
export default App;
