import {Footer}  from './components/Footer';
import './App.css';
import Navbar from './components/Navbar';
import Welcome from './components/Welcome';
import Login from './components/Login';

function App() {
  return (
    <div className="App">
      <div className="flex items-center justify-center  pt-10  bg-fixed bg-center bg-fit bg-[url('./banner.png')]  h-80 ">
        <div className="mt-25 md:mt-0 ">         
            <div className="text-center font-bold text-4xl leading-loose uppercase col-span-full sm:col-span-2 px-5 ">
              <p>Crowd Point</p>
            </div>
        </div>
      </div>
      <div className="bg-sky-200">  
         <Navbar/>
        {/* <Welcome/>  */}
        {/* Footer */}
        <Login/>
        {/* <Footer/> */}
      </div>
    </div>
  );
}

export default App;
