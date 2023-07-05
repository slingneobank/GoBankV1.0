public import androidx.appcompat.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.Switch;

import com.pinelabs.pineperks.interfaces.CardManagerObserver;
import com.pinelabs.pineperks.screens.components.CardCvvTextView;
import com.pinelabs.pineperks.screens.components.CardExpiryDateTextView;
import com.pinelabs.pineperks.screens.components.CardIssueDateTextView;
import com.pinelabs.pineperks.screens.components.CardNumberTextView;
import com.pinelabs.pineperks.sdk.CardManager;
import com.pinelabs.pineperks.sdk.PineLabsSDK;
import com.pinelabs.pineperks.sdk.models.PLCardResponse;

import android.widget.SwitchCompat;
import android.app.ProgressDialog;

public class CustomCardViewActivity extends AppCompatActivity implements CardManagerObserver {
    private CardManager cardManager;
    private static final String workingKey = "<GIVEN BY PINE LABS TEAM>";
    private static final String USERNAME = "<GIVEN BY PINE LABS TEAM>";
    private static final String URI = "<GIVEN BY PINE LABS TEAM>";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_custom_card_view);

        // Initialize PineLabsSDK and get CardManager instance
        PineLabsSDK pineLabsSDK = new PineLabsSDK(URI);
        cardManager = pineLabsSDK.getCardManager(this);
        initialize();

        // Handle the toggle switch for showing/hiding card details
        Switch showCardSwitch = findViewById(R.id.showCardToggle);
        showCardSwitch.setOnCheckedChangeListener((buttonView, isChecked) -> {
            if (isChecked) {
                showCardDetails();
            } else {
                maskCardDetails();
            }
        });
    }

    // Initialize the encrypted clientKey, cardReferenceNumber, and username
    private void initialize() {
        String clientKey = cardManager.getRandomKey();
        Log.i("APP", "randomKey: " + clientKey);
        String encryptedClientKey = encrypt(clientKey, workingKey);
        String encryptedReferenceNumber = encrypt("<CARD_REFERENCE_NUMBER>", workingKey);
        cardManager.setCredentials(encryptedClientKey, encryptedReferenceNumber, USERNAME);
    }
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContentView(R.layout.activity_custom_card_view);

    SwitchCompat showCardSwitch = findViewById(R.id.showCardToggle);
    showCardSwitch.setOnCheckedChangeListener((buttonView, isChecked) -> {
        if (isChecked) {
            progressDialog = new ProgressDialog(this);
            progressDialog.setMessage("loading...");
            progressDialog.show();
            // ask SDK to render card details in custom view components
            cardManager.showCardDetails(this);
        } else {
            cardManager.maskCardDetails(this);
        }
    });
}


    // Show the card details in the custom views
    private void showCardDetails() {
        cardManager.showCardDetails(this);
    }

    // Mask/hide the card details in the custom views
    private void maskCardDetails() {
        cardManager.maskCardDetails(this);
    }

    @Override
    public void onReceive(PLCardResponse plCardResponse) {
        int responseCode = plCardResponse.getResponseCode();
        String responseMessage = plCardResponse.getResponseMessage();
        // Handle the card response based on the response code and message
        // ...

        // Example code for displaying card details in custom views
        if (responseCode == 200) {
            CardNumberTextView cardNumberTextView = findViewById(R.id.number1);
            CardIssueDateTextView cardIssueDateTextView = findViewById(R.id.issueDate);
            CardExpiryDateTextView cardExpiryDateTextView = findViewById(R.id.expiryDate);
            CardCvvTextView cardCvvTextView = findViewById(R.id.cvv);

            cardNumberTextView.setCardNumber(plCardResponse.getCardNumber());
            cardIssueDateTextView.setIssueDate(plCardResponse.getIssueDate());
            cardExpiryDateTextView.setExpiryDate(plCardResponse.getExpiryDate());
            cardCvvTextView.setCvv(plCardResponse.getCvv());
        }
    }

    // Helper method to encrypt the data using working key
    private String encrypt(String data, String workingKey) {
        // Implement the encryption logic using the workingKey
        // ...
        return encryptedData;
    }
}
 {
    
}
