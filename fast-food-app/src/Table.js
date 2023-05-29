import React from 'react'
import JsonData from './menu.json'
 
//From:https://www.geeksforgeeks.org/how-to-parse-json-data-into-react-table-component/

async function getMenu() {
    // try {
    //     const response = fetch('localhost:5000/menu');
    //     return response.json();
    // } catch(error) {
    //     console.log(error)
    // }
    await fetch('http://localhost:5000/menu', {
        method: "GET", // *GET, POST, PUT, DELETE, etc.
        mode: "cors", // no-cors, *cors, same-origin
    }).then(result => result.json())
    .then(data => {
        console.log(data);
    })
    .catch(error => console.log(error.message));
}

export default function Table(){
    getMenu();
    const DisplayData=JsonData.items.map(
        (info)=>{
            return(
                <tr>
                    <td>{info.ItemNumber}</td>
                    <td>{info.ItemName}</td>
                    <td>{'$'+info.Price}</td>
                </tr>
            )
        }
    )
    return(
        <div>
            
            <table class="table table-striped">
                <thead>
                    <tr>
                    <th>Item #</th>
                    <th>Name</th>
                    <th>Price</th>
                    </tr>
                </thead>
                <tbody>
                 
                    {DisplayData}
                    
                </tbody>
            </table>
             
        </div>
    )
 }
