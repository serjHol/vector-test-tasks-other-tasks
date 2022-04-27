//Task 1

const createAdd = (number) => {
	return (paramNumber) => {
		return number + paramNumber;
	};
};

//const createAdd = number => paramNumber => number + paramNumber; or like this

// EXAMPLES
// const add5 = createAdd(5);
// const add10 = createAdd(10);
// console.log(add5(3)); // logs 8
// console.log(add10(3)); //logs 13

// Task 2

const squaredArray = (array) => {
	return array.map((number) => number ** 2);
};

// EXAMPLES
// console.log(squaredArray([1, 2, 3, 4, 5])) //logs [1, 4, 9, 16, 25]

// Task 3

const productOfNumbers = (array) => {
	if (!array?.length) {
		return 0;
	}
	return array.reduce((acc, current) => {
		return acc * current;
	});
};

// EXAMPLES
// console.log(productOfNumbers([1, 2, 3, 4, 5])) //logs 120
