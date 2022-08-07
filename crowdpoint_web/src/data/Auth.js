import { getAuth, createUserWithEmailAndPassword, signOut,signInWithEmailAndPassword } from "firebase/auth";
const auth = getAuth();
export const Signup = (email,password) => {
  return (
    createUserWithEmailAndPassword(auth, email, password)
  .then((userCredential) => {
    // Signed in 
    const user = userCredential.user;
    // ...
  })
  .catch((error) => {
    const errorCode = error.code;
    const errorMessage = error.message;
    // ..
  })
  )
}


export const Signin = (email,password) => {
  return (
    signInWithEmailAndPassword(auth, email, password)
  .then((userCredential) => {
    // Signed in 
    const user = userCredential.user;
    // ...
  })
  .catch((error) => {
    const errorCode = error.code;
    const errorMessage = error.message;
  })

  )
}
export const Signout = () => {
  return (
    signOut(auth).then(() => {
        // Sign-out successful.
      }).catch((error) => {
        // An error happened.
      })
  )
}
