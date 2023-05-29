import React from 'react'
import JsonData from './menu.json'
 
//From:https://www.geeksforgeeks.org/how-to-parse-json-data-into-react-table-component/

export default function Table(){
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
