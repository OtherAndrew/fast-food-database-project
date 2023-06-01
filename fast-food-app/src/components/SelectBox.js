/**
 * Returns a dropdown menu.
 * @param props Dropdown options.
 * @return {JSX.Element} A dropdown menu.
 * @constructor
 */
export default function SelectBox(props) {
  return (
    <select name={props.name} onChange= {props.handle} disabled = {props.disabled} value = {props.value}>
      <option value="">--Please choose an option--</option>
      {props.options}
    </select>
  );
}