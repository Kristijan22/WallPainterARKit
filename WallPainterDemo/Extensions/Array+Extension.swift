extension Array {

    /**
     Allows for returning of 'nil' values in case a specified index is out of bounds.

     - parameter index: Index of array element to return.
     - returns: Array element or 'nil' if index is out of array bounds.
     */
    func at(_ index: Int) -> Element? {
        if 0 <= index && index < count {
            return self[index]
        } else {
            return nil
        }
    }

}
