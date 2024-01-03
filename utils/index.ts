const randomStringGenerator: (maxCharLength?: number) => string = (maxCharLength = 6) => {
  const letters = 'QWERTYUIOPASDFGHJKLZXCVBNM'
  const digits = '1234567890'

  const generateRandomLetterIdx = () => Math.floor(Math.random() * letters.length)
  const generateRandomDigitIdx = () => Math.floor(Math.random() * digits.length)

  let randomisedString = ''
  while (randomisedString.length < maxCharLength) {
    let randomLetterIdx = generateRandomLetterIdx()
    let randomDigitIdx = generateRandomDigitIdx()

    if (randomLetterIdx === letters.length) {
      randomLetterIdx -= 1
    }
    if (randomDigitIdx === digits.length) {
      randomDigitIdx -= 1
    }

    const acceptedChar = Math.floor(Math.random() * 2) % 2 ? letters[randomLetterIdx] : digits[randomDigitIdx]
    randomisedString += acceptedChar
  }
  return randomisedString
}

export { randomStringGenerator }
