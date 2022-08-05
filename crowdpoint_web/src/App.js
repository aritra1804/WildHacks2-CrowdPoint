import {Footer}  from './components/Footer';
import './App.css';

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
        <div className="grid grid-cols-4 gap-4 p-3 bg-black">
          <div className="col-span-1"></div>
          <p className=" text-white uppercase font-bold col-span-1 text-left rounded-full hover:text-red-300">
           Admin Login
          </p>
          <p className="font-bold text-white uppercase
           col-span-1 justify-end text-right rounded-full hover:text-green-300">
            View data 
          </p>
          <div className="col-span-1"></div>
        </div>   
        <div className="rounded  m-5 items-center-center ">
          
          
            <p className="font-bold  px-5  text-lg">
              About Us
            </p>
            <p className="p-5  leading-loose font-serif ">
            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. A condimentum vitae sapien pellentesque habitant. Mi in nulla posuere sollicitudin. Egestas quis ipsum suspendisse ultrices. Pretium aenean pharetra magna ac placerat vestibulum lectus. Nunc sed velit dignissim sodales ut. Turpis egestas integer eget aliquet nibh praesent tristique magna sit. Tristique sollicitudin nibh sit amet commodo. Sit amet dictum sit amet justo donec. Viverra ipsum nunc aliquet bibendum enim facilisis gravida neque convallis. In dictum non consectetur a erat nam at lectus urna.

Ut pharetra sit amet aliquam id diam maecenas ultricies mi. Morbi quis commodo odio aenean sed adipiscing. Aliquet nec ullamcorper sit amet risus nullam. Pellentesque habitant morbi tristique senectus. Tortor at risus viverra adipiscing at in tellus integer feugiat. Ullamcorper velit sed ullamcorper morbi tincidunt. Fermentum iaculis eu non diam phasellus vestibulum lorem sed risus. Ullamcorper malesuada proin libero nunc consequat interdum varius sit. Proin fermentum leo vel orci porta non pulvinar. Vulputate dignissim suspendisse in est ante in. Nec feugiat in fermentum posuere urna nec tincidunt. Diam vulputate ut pharetra sit amet aliquam. Pellentesque massa placerat duis ultricies lacus sed. Sem viverra aliquet eget sit amet tellus.
            </p>
            <div className="flex justify-center">
            <p className="font-bold p-4 w-4/6 text-center ml-7 bg-gray-200 border border-red-400  rounded-full hover:bg-red-500   text-lg">
              !! Download Now !!
            </p></div>
            
            <p className="font-bold px-5  text-lg">Our Team</p>
            {/* <img></img> */}
            <p className="p-5">
              Contributions will be indexed by Elsevier Procedia Scopus and
              Clarivate Conference Proceedings Citation Index – Web of Science
              (former ISI Thomson) and will be available on Sciverse
              ScienceDirect.
            </p>
          
        </div>
        {/* Footer */}
        <Footer/>
      </div>
    </div>
  );
}

export default App;
