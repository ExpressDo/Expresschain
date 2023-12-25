use traits::TryInto;
use option::OptionTrait;

fn main() {
    let x: felt252 = 56; //x is of type felt252
    let y: u64 = x.try_into().unwrap(); //Since a felt252 might not fit in a u64, we need to unwrap the Option<T> type
}

