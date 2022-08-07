import { initializeApp } from "firebase/app"
import { getFirestore } from "firebase/firestore"

const firebaseConfig = {
    apiKey: "AIzaSyDacWP53-MftILm6KSCw_NgN7xd8OyTsKg",
    authDomain: "crowdpoint-fc7ef.firebaseapp.com",
    projectId: "crowdpoint-fc7ef",
    storageBucket: "crowdpoint-fc7ef.appspot.com",
    messagingSenderId: "111068910617",
    appId: "1:111068910617:web:e5916b1204149fabc0c688",
    measurementId: "G-0ZBX38TGPL"
  };
  const app = initializeApp(firebaseConfig)
const db = getFirestore(app)

export {db}