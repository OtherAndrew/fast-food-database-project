export default function MenuTable(props) {
    return (
        <select name={props.name} onChange= {props.handle} disabled = {props.disabled} value = {props.value}>
            <option value="">--Please choose an option--</option>
            {props.options}
        </select>
    );
}

