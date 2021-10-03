import './styles/App.css';
import twitterLogo from './assets/twitter-logo.svg';
import React, { useEffect, useState } from 'react';
import { ethers } from 'ethers';
import { abi } from "./utils/ShinChanNFT.json";

const TWITTER_HANDLE = '_buildspace';
const TWITTER_LINK = `https://twitter.com/${TWITTER_HANDLE}`;
// const OPENSEA_LINK = '';
// const TOTAL_MINT_COUNT = 50;

function App() {
  const [currentAccount, setCurrentAccount] = useState("")
  // deployed rinkeby contract address
  const CONTRACT_ADDRESS = "0x9cb54203C6eFd34b3F0500D5c2b0310DEcF947C1";
  const contractAbi = abi;

  // check if user has wallet connected
  const checkForWallet = async () => {
    const { ethereum } = window;

    if (!ethereum) {
      console.log("Make sure you have metamask!");
      return;
    } else {
      console.log("We have the ethereum object", ethereum);
    }

    const accounts = await ethereum.request({ method: 'eth_accounts' });

    if (accounts.length !== 0) {
      const account = accounts[0];
      console.log("Found an authorize account:", account);
      setCurrentAccount(account);
    } else {
      console.log("No authorized account found");
    }
  }

  const connectWallet = async () => {
    try {
      const { ethereum } = window;
  
      if (!ethereum) {
        alert('Get MetaMask!')
        return;
      }
  
      const accounts = await ethereum.request({ method: 'eth_requestAccounts' });

      console.log("Connected", accounts[0]);
      setCurrentAccount(accounts[0]);

    } catch (error) {
      console.error(error)
    }
  }

  const haveContractMintNFT = async () => {
    console.log('mint!')
    try {
      const { ethereum } = window;

      if (ethereum) {
        const provider = new ethers.providers.Web3Provider(ethereum);
        const signer = provider.getSigner();
        const connectedContract = new ethers.Contract(CONTRACT_ADDRESS, contractAbi, signer);

        console.log('paying gas...');
        let nftTxn = await connectedContract.makeShinChanNFT();

        console.log('mining please wait...')
        await nftTxn.wait();
        console.log(`Finished, See transaction: https://rinkeby.etherscan.io/tx/${nftTxn.hash}`)

      } else {
        console.log('Ethereum object does not exist!');
      }
    } catch (error) {
      console.error(error);
    }
  }

  useEffect(() => {
    checkForWallet();
  }, [])

  return (
    <div className="App">
      <div className="App">
      <div className="container">
        <div className="header-container">
          <p className="header gradient-text">My NFT Collection</p>
          <p className="sub-text">
            Each unique. Each beautiful. Discover your NFT today.
            </p>
            <p className="sub-text">Use with Rinkeby Testnet Only!</p>

            {currentAccount && (
              <button className="cta-button connect-wallet-button" onClick={haveContractMintNFT}>
                Mint NFT
              </button>
            )}

            {!currentAccount && (
              <button className="cta-button connect-wallet-button" onClick={connectWallet}>
                Connect MetaMask Wallet
              </button>
            )}

        </div>
          <div className="footer-container">
          <img alt="Twitter Logo" className="twitter-logo" src={twitterLogo} />
          <a
            className="footer-text"
            href={TWITTER_LINK}
            target="_blank"
            rel="noreferrer"
          >{`built on @${TWITTER_HANDLE}`}</a>
        </div>
      </div>
    </div>
    </div>
  );
}

export default App;
