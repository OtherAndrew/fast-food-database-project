import React from 'react'
import JsonData from './menu.json'
 
//From:https://www.geeksforgeeks.org/how-to-parse-json-data-into-react-table-component/

function getMenu() {
    // try {
    //     const response = fetch('localhost:5000/menu');
    //     return response.json();
    // } catch(error) {
    //     console.log(error)
    // }
    fetch('http://localhost:5000/menu')
        .then(result => result.json())
        .then(json => {
            console.log(json)
        })
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
