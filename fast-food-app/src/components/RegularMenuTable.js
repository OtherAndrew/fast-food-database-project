export default function RegularMenuTable(props) {
    return (
        <div className="table">
            {props.loading ? (
                <div>Loading...</div>
            ) : (
                <>
                    <table border={1}>
                        <tr>
                            <th>Item #</th>
                            <th>Item</th>
                            <th>Price</th>
                        </tr>
                        {props.menu.items?.map (item => {
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
    );
}

