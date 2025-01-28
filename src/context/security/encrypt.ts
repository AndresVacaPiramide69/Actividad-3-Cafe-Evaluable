import bcrypt from 'bcrypt';
const saltRounds = 10;

const hash = (text:string):string => {
    const salt = bcrypt.genSaltSync(saltRounds);
    return bcrypt.hashSync(text, salt)
}

const compare = (text:string, encoded:string):boolean => {
    return bcrypt.compareSync(text, encoded);
}

export { hash, compare };