import banner from './Banner.png'
import {useReducer, useState} from 'react';
import './App.css';
//Help from tutorials: https://www.digitalocean.com/community/tutorials/how-to-build-forms-in-react

const formReducer = (state, event) => {
  return {
    ...state,
    [event.name]: event.value
  }
}


function App() {
  const [formData, setFormData] = useReducer(formReducer, {});
  const [submitting, setSubmitting] = useState(false);

  const handleSubmit = event => {
    event.preventDefault();
    setSubmitting(true);

    setTimeout(() =>{
      setSubmitting(false);
    }, 2000)
  }

  const handleChange = event => {
    setFormData({
      name: event.target.name,
      value:event.target.value,
    });
  }


  return(
    <div className = "wrapper">
      <h1>Burger shrine</h1>
      <img src = {banner} alt = {'Tasty burger'}/>
      <h2>Please place your order</h2>
      <form onSubmit={handleSubmit}>
        <fieldset> 
          <label> 
            <p>Name</p>
            <input name = "name" onChange={handleChange}/>
          </label>
        </fieldset>
        <button type = 'submit'>Submit</button>
      </form>
      {submitting && <div>
        <ul>
           {Object.entries(formData).map(([name, value]) => (
             <li key={name}><strong>{name}</strong>:{value.toString()}</li>
           ))}
         </ul>
        </div>}
    </div>
  );

}

// function App() {
//   return (
//     <div className="App">
//       <header className="App-header">
//         <img src={tenshi} className="App-logo" alt="logo" />
//         <p>
//           Angel Burgers
//         </p>
//       </header>
//       <header className="Tabs">
//         <button>Choose store</button>
//         <button>Edit Order</button>
//         <button>Finalize Order</button>
//       </header>
//     </div>
//   );
// }


export default App;
